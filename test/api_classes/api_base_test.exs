defmodule ProxerEx.Test.Api.Base do
  use ExUnit.Case, async: true

  defmodule TestApi do
    use ProxerEx.Api.Base, api_class: "test_api"

    api_func "test_func_without_params" do
      api_doc("DOC_TEXT")
    end

    api_func "test_func_with_params" do
      api_doc("DOC_TEXT")
      parameter("test_param_1", :get)
      parameter("test_param_2", :post)
    end

    api_func "test_func_with_authorization", authorization: true do
      parameter("test_param", :get)
    end

    api_func "test_func_with_extra_header", extra_header: [test_header: "header value"] do
      parameter("test_param", :post)
    end

    api_func "TESTFuncTo Escape" do
      api_doc("DOC_TEXT")
    end

    api_func "test_func_optional_parameter" do
      parameter("test_param_1", :post)
      parameter("test_param_2", :get, optional: true)
    end

    api_func "test_func_parameter_mutually_exclusive" do
      parameter("test_param_1", :get, not_with: ["test_param_2"])
      parameter("test_param_2", :post, not_with: ["test_param_1"])
    end

    api_func "test_func_with_paging_parameter" do
      paging_parameter()
    end

    @doc false
    def test_processing(%ProxerEx.Request{get_args: get_args} = request, _name, _value) do
      get_args =
        get_args
        |> Map.put("1", "value 1")
        |> Map.put("key 2", "value of key 2")

      {:ok, %{request | get_args: get_args}}
    end

    api_func "test_func_custom_processing" do
      parameter("test_param", :get, process: :test_processing)
    end
  end

  test "all functions are defined" do
    assert function_exported?(TestApi, :test_func_without_params, 0)
    assert function_exported?(TestApi, :test_func_with_params, 1)
    assert function_exported?(TestApi, :test_func_with_authorization, 1)
    assert function_exported?(TestApi, :test_func_with_extra_header, 1)
    assert function_exported?(TestApi, :test_func_optional_parameter, 1)
    assert function_exported?(TestApi, :test_func_parameter_mutually_exclusive, 1)
    assert function_exported?(TestApi, :test_func_custom_processing, 1)
  end

  test "function names are correctly escaped" do
    assert function_exported?(TestApi, :test_func_to_escape, 0)
    {:ok, request} = TestApi.test_func_to_escape()

    assert request == %ProxerEx.Request{
             method: :get,
             api_class: "test_api",
             api_func: "TESTFuncTo Escape"
           }
  end

  test "documentation exists where given" do
    # Currently not working due to limitations of Code.get_docs/2
  end

  test "correct request is returned without parameter" do
    {:ok, request} = TestApi.test_func_without_params()

    assert request == %ProxerEx.Request{
             method: :get,
             api_class: "test_api",
             api_func: "test_func_without_params"
           }
  end

  test "correct request is returned with parameters" do
    {:ok, request} =
      TestApi.test_func_with_params(test_param_1: "value1", test_param_2: "value 2")

    assert request == %ProxerEx.Request{
             method: :post,
             api_class: "test_api",
             api_func: "test_func_with_params",
             get_args: %{test_param_1: "value1"},
             post_args: [test_param_2: "value 2"]
           }
  end

  test "authorization option is passed through to the request" do
    {:ok, request} = TestApi.test_func_with_authorization(test_param: "value string")

    assert request == %ProxerEx.Request{
             method: :get,
             api_class: "test_api",
             api_func: "test_func_with_authorization",
             get_args: %{test_param: "value string"},
             authorization: true
           }
  end

  test "extra headers are passed through to the request" do
    {:ok, request} = TestApi.test_func_with_extra_header(test_param: "post value string")

    assert request == %ProxerEx.Request{
             method: :post,
             api_class: "test_api",
             api_func: "test_func_with_extra_header",
             post_args: [test_param: "post value string"],
             extra_header: [test_header: "header value"]
           }
  end

  describe "optional parameter are optional" do
    test "optional parameter must not be given" do
      {:ok, request} = TestApi.test_func_optional_parameter(test_param_1: "value1")

      assert request == %ProxerEx.Request{
               method: :post,
               api_class: "test_api",
               api_func: "test_func_optional_parameter",
               post_args: [test_param_1: "value1"]
             }
    end

    test "optional parameter are included in the request if given" do
      {:ok, request} =
        TestApi.test_func_optional_parameter(test_param_1: "value1", test_param_2: "value 2")

      assert request == %ProxerEx.Request{
               method: :post,
               api_class: "test_api",
               api_func: "test_func_optional_parameter",
               get_args: %{test_param_2: "value 2"},
               post_args: [test_param_1: "value1"]
             }
    end
  end

  test "mutually exclusive parameter are mutually exclusive" do
    {:error, _} = TestApi.test_func_parameter_mutually_exclusive(test_param_1: "value", test_param_2: "asfzas")
  end

  test "custom processing function is called" do
    {:ok, request} = TestApi.test_func_custom_processing(test_param: "val")

    assert request == %ProxerEx.Request{
             method: :get,
             api_class: "test_api",
             api_func: "test_func_custom_processing",
             get_args: %{"1" => "value 1", "key 2" => "value of key 2"}
           }
  end

  test "paged parameter are added" do
    {:ok, request} = TestApi.test_func_with_paging_parameter(p: 1, limit: 200)

    assert request == %ProxerEx.Request{
             method: :get,
             api_class: "test_api",
             api_func: "test_func_with_paging_parameter",
             get_args: %{p: 1, limit: 200}
           }
  end
end
