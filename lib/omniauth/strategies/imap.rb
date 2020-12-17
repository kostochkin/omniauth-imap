
module OmniAuth
  module Strategies
    class IMAP
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
        end.to_response
      end

      def callback_phase
        imap = Net::IMAP.new(options[:host], options: {port: options[:port]})
        imap.starttls()
        imap.authenticate("PLAIN", username, request["password"])
        super
      rescue
        return fail!(:invalid_credentials)
      end

      uid do
        request['username']
      end
      
      info do
        email = options[:email_domain].nil? ? uid : "#{uid}@#{options[:email_domain]}"
        { nickname: uid, name: uid, email: email }
      end
    end
  end
end

OmniAuth.config.add_camelization 'imap', 'IMAP'
