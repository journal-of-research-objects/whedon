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

  alias testing? test?

  # Use github or not - currently just disables for BioHackrXiv
  def use_github?
    !journal_biohackrxiv?
  end

  def journal
    ENV['WHEDON_JOURNAL']
  end

  def journal_biohackrxiv?
    journal == "BioHackrXiv"
  end

  def output_destination
    dest = ENV['WHEDON_OUTPUT_DESTINATION']
    if dest == nil or dest == 'cloudinary'
      logger.debug("Output set to cloudinary")
      return :cloudinary
    else
      logger.debug("Output set to directory "+dest)
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
