defmodule ProxerEx.Api.Info do
  @moduledoc """
  Contains helper methods to build requests for the info api.
  """

  use ProxerEx.Api.Base, api_class: "info"

  api_func "character" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Character``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.character(id: 61)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "character",
           authorization: false,
           extra_header: [],
           get_args: %{},
           method: :post,
           post_args: [id: 61]
        }}

    """)

    parameter("id", :post)
  end

  api_func "characters" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Characters``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.characters(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "characters",
           authorization: false,
           extra_header: [],
           get_args: %{},
           method: :post,
           post_args: [id: 42]
        }}

    """)

    parameter("id", :post)
  end

  api_func "comments" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Comments``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.comments(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "comments",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

        iex> ProxerEx.Api.Info.comments(id: 42, p: 6, limit: 82, sort: "rating")
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "comments",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42, p: 6, limit: 82, sort: "rating"},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
    parameter("sort", :get, optional: true)
    paging_parameters()
  end

  api_func "entry" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Entry``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.entry(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "entry",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "entrygenres" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Entry Genres``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.entrygenres(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "entrygenres",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "entrytags" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Entry Tags``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.entrytags(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "entrytags",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "forum" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Forum``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.forum(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "forum",
           authorization: false,
           extra_header: [],
           get_args: %{},
           method: :post,
           post_args: [id: 42]
        }}

    """)

    parameter("id", :post)
  end

  api_func "fullentry" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Full Entry``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.fullentry(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "fullentry",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "gate" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Gate``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.gate(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "gate",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "groups" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Groups``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.groups(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "groups",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "industry" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Industry``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.industry(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "industry",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "lang" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Lang``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.lang(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "lang",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "listinfo" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Listinfo``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.listinfo(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "listinfo",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

        iex> ProxerEx.Api.Info.listinfo(id: 42, p: 5, limit: 12, includeNotAvailableChapters: true)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "listinfo",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42, p: 5, limit: 12, includeNotAvailableChapters: true},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
    parameter("includeNotAvailableChapters", :get, optional: true)
    paging_parameters()
  end

  api_func "names" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Names``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.names(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "names",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "person" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Person``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.person(id: 61)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "person",
           authorization: false,
           extra_header: [],
           get_args: %{},
           method: :post,
           post_args: [id: 61]
        }}

    """)

    parameter("id", :post)
  end

  api_func "persons" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Persons``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.persons(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "persons",
           authorization: false,
           extra_header: [],
           get_args: %{},
           method: :post,
           post_args: [id: 42]
        }}

    """)

    parameter("id", :post)
  end

  api_func "publisher" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Publisher``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.publisher(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "publisher",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "recommendations" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Recommendations``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.recommendations(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "recommendations",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "relations" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Relations``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.relations(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "relations",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

        iex> ProxerEx.Api.Info.relations(id: 42, isH: true)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "relations",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42, isH: true},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
    parameter("isH", :get, optional: true)
  end

  api_func "season" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Seasons``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.season(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "season",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "setuserinfo", authorization: true do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Set Userinfo``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.setuserinfo(id: 42, type: "note")
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "setuserinfo",
           authorization: true,
           extra_header: [],
           get_args: %{},
           method: :post,
           post_args: [id: 42, type: "note"]
        }}

    """)

    parameter("id", :post)
    parameter("type", :post)
  end

  api_func "translatorgroup" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Translatorgroup``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.Info.translatorgroup(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "translatorgroup",
           authorization: false,
           extra_header: [],
           get_args: %{id: 42},
           method: :get,
           post_args: []
        }}

    """)

    parameter("id", :get)
  end

  api_func "userinfo", authorization: true do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```Info/Get Userinfo``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    Because this function tries to view the information of the authenticated user, it is required to set
    `ProxerEx.Request.authorization` to `true`.

    ## Examples

        iex> ProxerEx.Api.Info.userinfo(id: 42)
        {:ok,
         %ProxerEx.Request{
           api_class: "info",
           api_func: "userinfo",
           authorization: true,
           extra_header: [],
           get_args: %{},
           method: :post,
           post_args: [id: 42]
        }}

    """)

    parameter("id", :post)
  end
end
