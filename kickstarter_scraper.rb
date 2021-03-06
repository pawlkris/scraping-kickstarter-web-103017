# require libraries/modules here
require "nokogiri"
require "pry"

def create_project_hash
  # write your code here

  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  projects_hash = {}
  projects = kickstarter.css("li.project.grid_4")
  projects.each do |x|
    title = x.css("h2.bbcard_name strong a").text
    image = x.css("div.project-thumbnail a img").attribute("src").value
    description = x.css("p.bbcard_blurb").text
    location = x.css("li a span.location-name").text
    percentage_funded = x.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    projects_hash[title] = {
    :image_link => image,
    :description => description,
    :location => location,
    :percent_funded => percentage_funded
    }
  end
  projects_hash
end
