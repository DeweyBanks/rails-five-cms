# EHE configuration settings
EHEANDME_LANDING_URI = 'https://www.eheandme.com/landing/signin'.freeze
EHEANDME_HOME = EHEANDME_LANDING_URI.freeze #'https://eheandme.com'.freeze

# Internal Links
EHE_COMMANDERS_IN_WELLNESS = '/commanders_in_wellness'.freeze
EHE_LOCATIONS = '/locations'.freeze
EHE_ABOUT = '/about'.freeze
EHE_TEAM = '/commanders_in_wellness'.freeze

META_DESCRIPTION = 'For over 100 years, EHE has been the leader in health care and wellbeing. We are pioneers in employee health and lifestyle management.'.freeze

GOOGLE_ANALYTICS =
  if ENV['EHE_GOOGLE_ANALYTICS']
    <<-TAG
      <!-- Global site tag (gtag.js) - Google Analytics -->
      <script async src="https://www.googletagmanager.com/gtag/js?id=#{ENV['EHE_GOOGLE_ANALYTICS']}"></script>
      <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', '#{ENV['EHE_GOOGLE_ANALYTICS']}');
      </script>
    TAG
  else
    ''
  end.freeze
