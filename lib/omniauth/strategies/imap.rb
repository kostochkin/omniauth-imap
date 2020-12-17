module OmniAuth
  module Strategies
    class Imap
      include OmniAuth::Strategy
      
      require "net/imap"

      option :name, 'imap'
      option :fields, [:username]
      option :uid_field, :username
      option :email_domain, nil
      option :port, 143
      option :host, "mail.example.com"

      def request_phase
        OmniAuth::Form.build(
          title: (options[:title] || "IMAP authentication"),
          url: callback_path,
        ) do |field|
          field.text_field 'Username', 'username'
          field.password_field 'Password', 'password'
          t = session[:_csrf_token]
          t_html = "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{t}\"/>"
	  field.html t_html
        end.to_response
      end

      def callback_phase
        imap = Net::IMAP.new(options[:host], options: {port: options[:port]})
        imap.starttls()
        imap.authenticate("PLAIN", uid, request[:password])
        super
      rescue SocketError
	return fail!(:server_communication_error)
      rescue Net::IMAP::NoResponseError => e
        return fail!(e.to_s)
      end

      uid do
        request[:username]
      end
      
      info do
        email = options[:email_domain].nil? ? uid : "#{uid}@#{options[:email_domain]}"
        { nickname: uid, name: uid, email: email }
      end
    end
  end
end

