
Pagy::DEFAULT[:items]  = 3                              # default
Pagy::DEFAULT[:size]       = [1,4,4,1]                       # default
Pagy::DEFAULT[:cycle]      = true                            # example
require 'pagy/extras/bootstrap'
require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :last_page    # default  (other options: :last_page and :exception)
Pagy::DEFAULT.freeze