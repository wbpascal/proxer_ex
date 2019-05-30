defmodule ProxerEx.Api.User do
  @moduledoc """
  Contains helper methods to build requests for the user api.
  """

  use ProxerEx.Api.Base, api_class: "user"

  api_func "about" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```User/Get About``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    To make sure the user is authorized to view the content the program is trying to access, it is
    recommended to set `ProxerEx.Request.authorization` to `true`. However this is not required and if
    left untouched the program must account for the possibility that the server may return an error if
    the information is not accessible to an anonymous user.

    ## Examples

        iex> ProxerEx.Api.User.about(uid: 1337)
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "about",
           authorization: false,
           extra_header: [],
           get_args: %{uid: 1337},
           method: :get,
           post_args: []
        }}

        iex> ProxerEx.Api.User.about()
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "about",
           authorization: false,
           extra_header: [],
           get_args: %{},
           method: :get,
           post_args: []
        }}

    """)

    parameter("uid", :get, optional: true, not_with: ["username"])
    parameter("username", :get, optional: true, not_with: ["uid"])
  end

  api_func "checkauth" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```User/Check Authentification``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> code = 1..100 |> Enum.reduce("", fn _, acc -> acc <> "0" end)
        iex> ProxerEx.Api.User.checkauth(name: "Example App", code: code)
        {:ok,
          %ProxerEx.Request{
            api_class: "user",
            api_func: "checkauth",
            authorization: false,
            extra_header: [],
            get_args: %{name: "Example App"},
            method: :post,
            post_args: [
              code: "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
            ]
        }}

    """)

    parameter("name", :get)
    parameter("code", :post)
  end

  api_func "comments" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```User/Get Latest Comments``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    To make sure the user is authorized to view the content the program is trying to access, it is
    recommended to set `ProxerEx.Request.authorization` to `true`. However this is not required and if
    left untouched the program must account for the possibility that the server may return an error if
    the information is not accessible to an anonymous user.

    ## Examples

        iex> ProxerEx.Api.User.comments(uid: 163825, kat: "manga", length: 250, p: 1, limit: 12)
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "comments",
           authorization: false,
           extra_header: [],
           get_args: %{kat: "manga", uid: 163825, length: 250, p: 1, limit: 12},
           method: :get,
           post_args: []
        }}

        iex> ProxerEx.Api.User.comments(uid: 163825)
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "comments",
           authorization: false,
           extra_header: [],
           get_args: %{uid: 163825},
           method: :get,
           post_args: []
        }}

    """)

    parameter("uid", :get, not_with: ["username"])
    parameter("username", :get, not_with: ["uid"])
    parameter("kat", :get, optional: true)
    parameter("length", :get, optional: true)
    paging_parameters()
  end

  api_func "friends" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```User/Get Friends``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    To make sure the user is authorized to view the content the program is trying to access, it is
    recommended to set `ProxerEx.Request.authorization` to `true`. However this is not required and if
    left untouched the program must account for the possibility that the server may return an error if
    the information is not accessible to an anonymous user.

    ## Examples

        iex> ProxerEx.Api.User.friends(uid: 1337)
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "friends",
           authorization: false,
           extra_header: [],
           get_args: %{uid: 1337},
           method: :get,
           post_args: []
        }}

        iex> ProxerEx.Api.User.friends()
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "friends",
           authorization: false,
           extra_header: [],
           get_args: %{},
           method: :get,
           post_args: []
        }}

    """)

    parameter("uid", :get, optional: true, not_with: ["username"])
    parameter("username", :get, optional: true, not_with: ["uid"])
  end

  api_func "history" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```User/Get History``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    To make sure the user is authorized to view the content the program is trying to access, it is
    recommended to set `ProxerEx.Request.authorization` to `true`. However this is not required and if
    left untouched the program must account for the possibility that the server may return an error if
    the information is not accessible to an anonymous user.

    ## Examples

        iex> ProxerEx.Api.User.history(uid: 154371, isH: true, p: 5, limit: 24)
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "history",
           authorization: false,
           extra_header: [],
           get_args: %{uid: 154371, isH: true, p: 5, limit: 24},
           method: :get,
           post_args: []
        }}

        iex> ProxerEx.Api.User.history(uid: 154371)
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "history",
           authorization: false,
           extra_header: [],
           get_args: %{uid: 154371},
           method: :get,
           post_args: []
        }}

    """)

    parameter("uid", :get, not_with: ["username"])
    parameter("username", :get, not_with: ["uid"])
    parameter("isH", :get, optional: true)
    paging_parameters()
  end

  api_func "list" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```User/Get List``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    To make sure the user is authorized to view the content the program is trying to access, it is
    recommended to set `ProxerEx.Request.authorization` to `true`. However this is not required and if
    left untouched the program must account for the possibility that the server may return an error if
    the information is not accessible to an anonymous user.

    ## Examples

        iex> ProxerEx.Api.User.list(username: "Username", kat: "manga", search: "test",
        ...> search_start: "test_start", isH: true, sort: "nameASC", filter: "stateFilter1",
        ...> p: 1, limit: 10)
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "list",
           authorization: false,
           extra_header: [],
           get_args: %{
              username: "Username",
              kat: "manga",
              search: "test",
              search_start: "test_start",
              isH: true,
              sort: "nameASC",
              filter: "stateFilter1",
              p: 1,
              limit: 10
           },
           method: :get,
           post_args: []
        }}

        iex> ProxerEx.Api.User.list(uid: 157584)
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "list",
           authorization: false,
           extra_header: [],
           get_args: %{uid: 157584},
           method: :get,
           post_args: []
        }}

    """)

    parameter("uid", :get, not_with: ["username"])
    parameter("username", :get, not_with: ["uid"])
    parameter("kat", :get, optional: true)
    parameter("search", :get, optional: true)
    parameter("search_start", :get, optional: true)
    parameter("isH", :get, optional: true)
    parameter("sort", :get, optional: true)
    parameter("filter", :get, optional: true)
    paging_parameters()
  end

  api_func "login" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```User/Login``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.User.login(username: "name", password: "passwd", secretkey: "918247")
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "login",
           authorization: false,
           extra_header: [],
           get_args: %{},
           method: :post,
           post_args: [username: "name", password: "passwd", secretkey: "918247"]
        }}

    """)

    parameter("username", :post)
    parameter("password", :post)
    parameter("secretkey", :post, optional: true)
  end

  api_func "logout", authorization: true do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```User/Logout``` api.

    ## Examples

        iex> ProxerEx.Api.User.logout()
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "logout",
           authorization: true,
           extra_header: [],
           get_args: %{},
           method: :get,
           post_args: []
        }}

    """)
  end

  api_func "requestauth" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```User/Request Authentification``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> code = 1..100 |> Enum.reduce("", fn _, acc -> acc <> "0" end)
        iex> ProxerEx.Api.User.requestauth(uid: 177103, name: "Example App", code: code)
        {:ok,
          %ProxerEx.Request{
            api_class: "user",
            api_func: "requestauth",
            authorization: false,
            extra_header: [],
            get_args: %{name: "Example App", uid: 177103},
            method: :post,
            post_args: [
              code: "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
            ]
        }}

    """)

    parameter("uid", :get, not_with: ["username"])
    parameter("username", :get, not_with: ["uid"])
    parameter("name", :get)
    parameter("code", :post)
  end

  api_func "topten" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```User/Get Topten``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    To make sure the user is authorized to view the content the program is trying to access, it is
    recommended to set `ProxerEx.Request.authorization` to `true`. However this is not required and if
    left untouched the program must account for the possibility that the server may return an error if
    the information is not accessible to an anonymous user.

    ## Examples

        iex> ProxerEx.Api.User.topten(username: "Username", kat: "manga", isH: true)
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "topten",
           authorization: false,
           extra_header: [],
           get_args: %{isH: true, kat: "manga", username: "Username"},
           method: :get,
           post_args: []
        }}

        iex> ProxerEx.Api.User.topten(username: "Username")
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "topten",
           authorization: false,
           extra_header: [],
           get_args: %{username: "Username"},
           method: :get,
           post_args: []
        }}

    """)

    parameter("uid", :get, not_with: ["username"])
    parameter("username", :get, not_with: ["uid"])
    parameter("kat", :get, optional: true)
    parameter("isH", :get, optional: true)
  end

  api_func "userinfo" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```User/Userinfo``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    If neither `uid` or `username` is given, information about the authenticated user is returned.
    In this case it is required to set `ProxerEx.Request.authorization` to `true`.

    ## Examples

        iex> ProxerEx.Api.User.userinfo(uid: 1337)
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "userinfo",
           authorization: false,
           extra_header: [],
           get_args: %{uid: 1337},
           method: :get,
           post_args: []
        }}

        iex> ProxerEx.Api.User.userinfo()
        {:ok,
         %ProxerEx.Request{
           api_class: "user",
           api_func: "userinfo",
           authorization: false,
           extra_header: [],
           get_args: %{},
           method: :get,
           post_args: []
        }}

    """)

    parameter("uid", :get, optional: true, not_with: ["username"])
    parameter("username", :get, optional: true, not_with: ["uid"])
  end
end
