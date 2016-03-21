module ApplicationHelper
	def bootstrap_class_for flash_type
		{ success: 'alert-success', error: 'alert-danger', warning: 'alert-warning'}[flash_type.to_sym]
	end

	def flash_messages(opts = {})
		flash.each do |msg_type, message|
			logger.debug msg_type
			concat(content_tag(:div, message, class: "text-center alert #{bootstrap_class_for(msg_type)} fade in") do
				concat content_tag(:button, 'x'.html_safe, class: 'close', data: {dismiss: 'alert'})
				concat message
			end)
			flash.clear
		end
		nil
	end

	def is_read(message_id)
		@read_message = Message.find(message_id)
		if @read_message
			@read_message.status == 1
		end
		false
	end

end
