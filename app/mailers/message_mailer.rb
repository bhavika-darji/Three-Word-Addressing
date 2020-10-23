class MessageMailer < ApplicationMailer
	def contact(message)
    	mail(to: 'bhavikad16@gmail.com', subject: "Contacted You by #{message.name} via #{message.email}", body: "#{message.body}")
  	end
end
