class HelperService::Response
  class << self
    def ok(data = 'Sucesso!')
      { status: :ok, data: { data: data } }
    end

    def created(data = 'Sucesso!')
      { status: :created, data: { data: data } }
    end

    def bad_request(data = 'Solicitação inválida!')
      { status: :bad_request, data: { error: data } }
    end

    def not_found(data = 'Nada encontrado!')
      { status: :not_found, data: { error: data } }
    end
  end
end