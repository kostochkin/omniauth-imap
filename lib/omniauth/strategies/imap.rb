module OmniAuth
  module Strategies
    class IMAP
      include OmniAuth::Strategy
      
      require Net::IMAP

      option :name, 'imap'
      option :fields, [:username]
      option :email_domain, nil

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
        imap = Net::IMAP.new(options[:host], options: {options[:port]})
        imap.starttls()
        imap.authenticate("PLAIN", username, request["password"])
        super
      rescue
        return fail!(:invalid_credentials)
      end

      username do
        request['username']
      end
      
      info do
        email = options[:email_domain].nil? username : "#{username}@#{options[:email_domain]}"
        { nickname: username, name: username, email: email }
      end
    end
  end
end

OmniAuth.config.add_camelization 'imap', 'IMAP'
