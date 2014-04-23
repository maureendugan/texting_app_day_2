class Automessage
  def self.send_automated_message(params)
    message = Message.new({to: params['From'][2..12], from: params['To'][2..12], body: "This is an unattended number"})
    message.save
  end
end
