# Handles global configuration settings

$stderr.print("Loading WhedonConfig...")

module WhedonConfig

  def app_env
    check 'APP_ENV'
  end

  def production?
    app_env == 'production'
  end

  def development?
    app_env == 'development'
  end

  def test?
    app_env == 'test'
  end

  def journal
    check 'WHEDON_JOURNAL'
  end

  def output_destination
    dest = ENV['WHEDON_OUTPUT_DESTINATION']
    if dest == nil or dest == 'cloudinary'
      return :cloudinary
    else
      return dest if File.directory?(dest)
    end
    raise "Environment WHEDON_OUTPUT_DESTINATION target directory #{dest} does not exist!"
  end

  private

  def check env
    raise "Environment #{env} is not set!" if not ENV[env]
    ENV[env]
  end

end
