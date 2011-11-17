class SphinxController < ApplicationController
  def index
    log_file = File.join(Rails.root, 'log', 'rake.log')

    if system("rake thinking_sphinx:index > #{log_file}")
      File.open(log_file, 'r') do |f|
        @output = f.read.gsub(/\n/, '<br>').html_safe
        flash[:success] = 'You have successfully reindexed the site.'
      end
    else
      flash[:error] = 'There was a problem indexing the site.'
    end
  end
end
