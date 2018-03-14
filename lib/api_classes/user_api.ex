defmodule ProxerEx.Api.User do
  @moduledoc """
  Contains helper methods to build requests for the user api.
  """

  use ProxerEx.Api.Base, api_class: "user"

  api_func "checkauth" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to check if an authentication request started through
    `ProxerEx.Api.User.requestauth/1` was approved by the user.

    ## Parameter
      * `name`: The `name` that was send with `ProxerEx.Api.User.requestauth/1`. **Always required**
      * `code`: The `code` that was send with `ProxerEx.Api.User.requestauth/1`. **Always required**

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
    Constructs a `ProxerEx.Request` that can be used to get all comments of a user sorted by the newest first.

    To make sure the user is authorized to view the content the program is trying to access, it is
    recommended to set `ProxerEx.Request.authorization` to `true`. However this is not required and if
    left untouched the program must account for the possibility that the server may return an error if
    the information is not accessible to an anonymous user.

    ## Parameter
      * `uid`: An integer representing the user id of the user that requests to be logged in.
        Required if `username` is not given. Returns an error if `username` is given at the same time.
      * `username`: A string representing the username of the user that rqeuests to be logged in.
        Required if `uid` is not given. Returns an error if `uid` is given at the same time.
      * `kat`: **Optional**. A string representing the category of topten the request will return.
        Either `"anime"` or `"manga"`. Default: both categories are returned
      * `length`: **Optional**. An integer representing the minimum length that each returned comment must be.
        Default: `300`
      * `p`: **Optional**. An integer representing the page of comments is loaded. Default: `0`
      * `limit`: **Optional**. An integer representing how many comments should be loaded per page. Default: `25`

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
    paging_parameter()
  end

  api_func "history" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to get the last episodes and chapters seen by a user.

    To make sure the user is authorized to view the content the program is trying to access, it is
    recommended to set `ProxerEx.Request.authorization` to `true`. However this is not required and if
    left untouched the program must account for the possibility that the server may return an error if
    the information is not accessible to an anonymous user.

    ## Parameter
      * `uid`: An integer representing the user id of the user that requests to be logged in.
        Required if `username` is not given. Returns an error if `username` is given at the same time.
      * `username`: A string representing the username of the user that rqeuests to be logged in.
        Required if `uid` is not given. Returns an error if `uid` is given at the same time.
      * `isH`: **Optional**. A boolean indicating whether or not adult content should be included in the response.
        Default: `false`
      * `p`: **Optional**. An integer representing the page of comments is loaded. Default: `0`
      * `limit`: **Optional**. An integer representing how many comments should be loaded per page. Default: `100`

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
    paging_parameter()
  end

  api_func "list" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to get a list of entries (anime or manga) a user
    has listed in his profile.

    To make sure the user is authorized to view the content the program is trying to access, it is
    recommended to set `ProxerEx.Request.authorization` to `true`. However this is not required and if
    left untouched the program must account for the possibility that the server may return an error if
    the information is not accessible to an anonymous user.

    ## Parameter
      * `uid`: An integer representing the user id of the user that requests to be logged in.
        Required if `username` is not given. Returns an error if `username` is given at the same time.
      * `username`: A string representing the username of the user that rqeuests to be logged in.
        Required if `uid` is not given. Returns an error if `uid` is given at the same time.
      * `kat`: **Optional**. A string representing the list category the request will return.
        Either `"anime"` or `"manga"`. Default: `anime`
      * `search`: **Optional**. A string representing a query that all entries should be filtered by.
      * `search_start`: **Optional**. A string that all returned entries should start with.
      * `isH`: **Optional**. A boolean indicating whether or not adult content should be included in the response.
        Default: `false`
      * `sort`: **Optional**. A string representing the order in which entries should be returned. Possible values:
        * `nameASC`: Sort by entry name ascending
        * `nameDESC`: Sort by entry name descending
        * `stateNameASC`: Sort by entry status first, then by name ascending (**Default**)
        * `stateNameDESC`: Sort by entry status first, then by name descending
        * `changeDateASC`: Sort by date the entry was last changed ascending
        * `changeDateDESC`: Sort by date the entry was last changed descending
        * `stateChangeDateASC`: Sort by entry status first, then by date the entry was last changed ascending
        * `stateChangeDateDESC`: Sort by entry status first, then by date the entry was last changed descending
      * `filter`: **Optional**. A string representing a filter that will be applied to the returned list.
        Possible values:
        * `stateFilterX`: Show only entries that have a status of X, where X is `0`(watched),
          `1`(currently watching), `2`(planning to watch) or `3`(cancelled).
      * `p`: **Optional**. An integer representing the page of comments is loaded. Default: `0`
      * `limit`: **Optional**. An integer representing how many comments should be loaded per page. Default: `100`

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
    paging_parameter()
  end

  api_func "login" do
    api_doc("""
    Constructs a `ProxerEx.Request` that can be used to login a user via a username and a password.

    ## Parameter

      * `username`: A string representing the username **Always Required**
      * `password`: A string representing the password of the user. **Always Required**
      * `secretkey`: A string representing a valid 2FA key of the user **Always Required**

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
    Constructs a `ProxerEx.Request` that can be used to logout an authorized user.

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
    Constructs a `ProxerEx.Request` that can be used to request the login of a specific user without
    using their password.

    For more detailed information go to the official documentation of
    [User/Request Authentification](https://proxer.me/wiki/Proxer_API/v1/User)

    ## Parameter
      * `uid`: An integer representing the user id of the user that requests to be logged in.
        Required if `username` is not given. Returns an error if `username` is given at the same time.
      * `username`: A string representing the username of the user that rqeuests to be logged in.
        Required if `uid` is not given. Returns an error if `uid` is given at the same time.
      * `name`: A string representing the name of the app that issued the request. **Always required**.
      * `code`: A 100 character long string representing the request. Can only be used once for each user.
        **Always required**.

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
    Constructs a `ProxerEx.Request` that can be used to get the topten anime or manga of a user.

    To make sure the user is authorized to view the content the program is trying to access, it is
    recommended to set `ProxerEx.Request.authorization` to `true`. However this is not required and if
    left untouched the program must account for the possibility that the server may return an error if
    the information is not accessible to an anonymous user.

    ## Parameter
      * `uid`: An integer representing the user id of the user that requests to be logged in.
        Required if `username` is not given. Returns an error if `username` is given at the same time.
      * `username`: A string representing the username of the user that rqeuests to be logged in.
        Required if `uid` is not given. Returns an error if `uid` is given at the same time.
      * `kat`: **Optional**. A string representing the category of topten the request will return.
        Either `"anime"` or `"manga"`. Default: `"anime"`
      * `isH`: **Optional**. A boolean indicating whether or not adult content should be included in the response.
        Default: `false`

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
    Constructs a `ProxerEx.Request` that can be used to get information about a user.

    If neither `uid` or `username` is given, information about the authenticated user is returned.
    In this case it is recommended to set `ProxerEx.Request.authorization` to `true`.

    ## Parameter
      * `uid`: An integer representing the user id of the user that requests to be logged in.
        Returns an error if `username` is given at the same time.
      * `username`: A string representing the username of the user that rqeuests to be logged in.
        Returns an error if `uid` is given at the same time.

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
