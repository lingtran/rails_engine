module Controller
  module JsonHelpers
    def response_body
      JSON.parse(response.body, symbolize_names: true, quirks_mode: true)
    end
  end
end
