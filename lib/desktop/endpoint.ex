defmodule Desktop.Endpoint do
  @doc false
  defmacro __using__(opts) do
    quote do
      use Phoenix.Endpoint, unquote(opts)
      defoverridable url: 0

      def url do
        url = :persistent_term.get({Phoenix.Endpoint, __MODULE__}, nil).url

        endpoint = Module.safe_concat(__MODULE__, HTTP)
        String.replace(url, ":0", ":#{:ranch.get_port(endpoint)}")
      end
    end
  end
end
