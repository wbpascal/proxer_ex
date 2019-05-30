defmodule ProxerEx.Api.List do
  @moduledoc """
  Contains helper methods to build requests for the list api.
  """

  use ProxerEx.Api.Base, api_class: "list"

  # Processing methods

  @doc false
  def to_plus_separated_string(%ProxerEx.Request{get_args: get_args} = request, name, value)
      when is_list(value) do
    get_args = get_args |> Map.put(name, Enum.join(value, "+"))
    {:ok, %{request | get_args: get_args}}
  end

  def to_plus_separated_string(%ProxerEx.Request{get_args: get_args} = request, name, value) do
    get_args = get_args |> Map.put(name, value)
    {:ok, %{request | get_args: get_args}}
  end

  # Api function definitions

  api_func "characters" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```List/Get Characters``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.List.characters(start: "a", contains: "b", search: "c", subject: "skills", p: 1, limit: 20)
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "characters",
            authorization: false,
            extra_header: [],
            get_args: %{start: "a", contains: "b", search: "c", subject: "skills", p: 1, limit: 20},
            method: :get
        }}
        iex> ProxerEx.Api.List.characters()
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "characters",
            authorization: false,
            extra_header: [],
            method: :get
        }}

    """)

    parameter("start", :get, optional: true)
    parameter("contains", :get, optional: true)
    parameter("search", :get, optional: true)
    parameter("subject", :get, optional: true)
    paging_parameters()
  end

  api_func "entrylist" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```List/Get Entry List``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.List.entrylist(kat: "anime", medium: "movie", isH: false, state: 1, year: 2001, season: 1,
        ...> season_type: "start", start: "a", sort: "clicks", sort_type: "DESC", p: 4, limit: 17)
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "entrylist",
            authorization: false,
            extra_header: [],
            get_args: %{
              kat: "anime",
              medium: "movie",
              isH: false,
              state: 1,
              year: 2001,
              season: 1,
              season_type: "start",
              start: "a",
              sort: "clicks",
              sort_type: "DESC",
              p: 4,
              limit: 17
            },
            method: :get
        }}
        iex> ProxerEx.Api.List.entrylist()
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "entrylist",
            authorization: false,
            extra_header: [],
            method: :get
        }}

    """)

    parameter("kat", :get, optional: true)
    parameter("medium", :get, optional: true)
    parameter("isH", :get, optional: true)
    parameter("state", :get, optional: true)
    parameter("year", :get, optional: true)
    parameter("season", :get, optional: true)
    parameter("season_type", :get, optional: true)
    parameter("start", :get, optional: true)
    parameter("sort", :get, optional: true)
    parameter("sort_type", :get, optional: true)
    paging_parameters()
  end

  api_func "entrysearch" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```List/Entry Search``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.List.entrysearch(name: "test", language: "de", type: "animeseries", genre: ["Action", "Adult"],
        ...> nogenre: ["Romance"], fsk: ["fsk18"], sort: "rating", length: 356, "length-limit": "up", tags: [60, 67],
        ...> notags: [4, 246, 85], tagratefilter: "rate_1", tagspoilerfilter: "spoiler_10", p: 2, limit: 3)
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "entrysearch",
            authorization: false,
            extra_header: [],
            get_args: %{
              name: "test",
              language: "de",
              type: "animeseries",
              genre: "Action+Adult",
              nogenre: "Romance",
              fsk: "fsk18",
              sort: "rating",
              length: 356,
              "length-limit": "up",
              tags: "60+67",
              notags: "4+246+85",
              tagratefilter: "rate_1",
              tagspoilerfilter: "spoiler_10",
              p: 2,
              limit: 3
            },
            method: :get
        }}
        iex> ProxerEx.Api.List.entrysearch()
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "entrysearch",
            authorization: false,
            extra_header: [],
            method: :get
        }}

    """)

    parameter("name", :get, optional: true)
    parameter("language", :get, optional: true)
    parameter("type", :get, optional: true)
    parameter("genre", :get, optional: true, process: :to_plus_separated_string)
    parameter("nogenre", :get, optional: true, process: :to_plus_separated_string)
    parameter("fsk", :get, optional: true, process: :to_plus_separated_string)
    parameter("sort", :get, optional: true)
    parameter("length", :get, optional: true)
    parameter("length-limit", :get, optional: true)
    parameter("tags", :get, optional: true, process: :to_plus_separated_string)
    parameter("notags", :get, optional: true, process: :to_plus_separated_string)
    parameter("tagratefilter", :get, optional: true)
    parameter("tagspoilerfilter", :get, optional: true)
    paging_parameters()
  end

  api_func "industryprojects" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```List/Get Industry Projects``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.List.industryprojects(id: 5, type: "record_label", isH: "0", p: 0, limit: 42)
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "industryprojects",
            authorization: false,
            extra_header: [],
            get_args: %{id: 5, type: "record_label", isH: "0", p: 0, limit: 42},
            method: :get
        }}
        iex> ProxerEx.Api.List.industryprojects(id: 5)
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "industryprojects",
            authorization: false,
            extra_header: [],
            get_args: %{id: 5},
            method: :get
        }}

    """)

    parameter("id", :get)
    parameter("type", :get, optional: true)
    parameter("isH", :get, optional: true)
    paging_parameters()
  end

  api_func "industrys" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```List/Get Industrys``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.List.industrys(start: "s", contains: "c", country: "jp", type: "publisher", p: 1, limit: 200)
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "industrys",
            authorization: false,
            extra_header: [],
            get_args: %{start: "s", contains: "c", country: "jp", type: "publisher", p: 1, limit: 200},
            method: :get
        }}
        iex> ProxerEx.Api.List.industrys()
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "industrys",
            authorization: false,
            extra_header: [],
            method: :get
        }}

    """)

    parameter("start", :get, optional: true)
    parameter("contains", :get, optional: true)
    parameter("country", :get, optional: true)
    parameter("type", :get, optional: true)
    paging_parameters()
  end

  api_func "persons" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```List/Get Persons``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.List.persons(start: "j", contains: "l", search: "k", subject: "awards", p: 9, limit: 120)
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "persons",
            authorization: false,
            extra_header: [],
            get_args: %{start: "j", contains: "l", search: "k", subject: "awards", p: 9, limit: 120},
            method: :get
        }}
        iex> ProxerEx.Api.List.persons()
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "persons",
            authorization: false,
            extra_header: [],
            method: :get
        }}

    """)

    parameter("start", :get, optional: true)
    parameter("contains", :get, optional: true)
    parameter("search", :get, optional: true)
    parameter("subject", :get, optional: true)
    paging_parameters()
  end

  api_func "tagids" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```List/Get Tag IDs``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.List.tagids(search: "4-Koma Arm -CGI-Animation")
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "tagids",
            authorization: false,
            extra_header: [],
            get_args: %{search: "4-Koma Arm -CGI-Animation"},
            method: :get
        }}

    """)

    parameter("search", :get)
  end

  api_func "tags" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```List/Get Tags``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.List.tags(search: "o", type: "entry_tag", sort: "id", sort_type: "DESC", subtype: "misc")
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "tags",
            authorization: false,
            extra_header: [],
            get_args: %{search: "o", type: "entry_tag", sort: "id", sort_type: "DESC", subtype: "misc"},
            method: :get
        }}
        iex> ProxerEx.Api.List.tags()
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "tags",
            authorization: false,
            extra_header: [],
            method: :get
        }}

    """)

    parameter("search", :get, optional: true)
    parameter("type", :get, optional: true)
    parameter("sort", :get, optional: true)
    parameter("sort_type", :get, optional: true)
    parameter("subtype", :get, optional: true)
  end

  api_func "translatorgroupprojects" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```List/Get Translatorgroup Projects``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.List.translatorgroupprojects(id: 42, type: 3, isH: 0, p: 91, limit: 1)
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "translatorgroupprojects",
            authorization: false,
            extra_header: [],
            get_args: %{id: 42, type: 3, isH: 0, p: 91, limit: 1},
            method: :get
        }}
        iex> ProxerEx.Api.List.translatorgroupprojects(id: 17)
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "translatorgroupprojects",
            authorization: false,
            extra_header: [],
            get_args: %{id: 17},
            method: :get
        }}

    """)

    parameter("id", :get)
    parameter("type", :get, optional: true)
    parameter("isH", :get, optional: true)
    paging_parameters()
  end

  api_func "translatorgroups" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to send a request to the ```List/Get Translatorgroups``` api.

    This method receives an optional keyword list as its only argument which represents the information send to
    the respective api. All keys must be named as seen in the official documentation. For further information
    take a look at the examples below.

    ## Examples

        iex> ProxerEx.Api.List.translatorgroups(start: "start", contains: "p", country: "en", p: 1, limit: 71)
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "translatorgroups",
            authorization: false,
            extra_header: [],
            get_args: %{start: "start", contains: "p", country: "en", p: 1, limit: 71},
            method: :get
        }}
        iex> ProxerEx.Api.List.translatorgroups()
        {:ok,
          %ProxerEx.Request{
            api_class: "list",
            api_func: "translatorgroups",
            authorization: false,
            extra_header: [],
            method: :get
        }}

    """)

    parameter("start", :get, optional: true)
    parameter("contains", :get, optional: true)
    parameter("country", :get, optional: true)
    paging_parameters()
  end
end
