class House < ApplicationRecord

  rails_admin do
    configure :player do
      label 'Owner of this ball: '
    end
  end

end
