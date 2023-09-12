class ServicesRegistry

    attr_reader :notification_service, :wine_service

    def initialize
      @notification_service = NotificationService.new
      @wine_service = WinesService.new(@notification_service)
    end


end