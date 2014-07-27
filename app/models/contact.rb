class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname,  :captcha  => true
  append :remote_ip, :user_agent, :session

  def headers 
    {
      :subject => "Every World City Contact.",
      :to => "climbonn@gmail.com",
      :cc => "mal.slider@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end