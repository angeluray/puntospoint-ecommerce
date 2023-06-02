module MockedRackSession
  extend ActiveSupport::Concern

  class MockSession < Hash
    def enabled?
      false
    end

    def destroy; end
  end

  included do
    before_action :set_mocked_session

    private

    def set_mocked_session
      request.env['rack.session'] ||= MockSession.new
    end
  end
end
