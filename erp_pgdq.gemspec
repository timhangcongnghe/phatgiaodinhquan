$:.push File.expand_path("../lib", __FILE__)

require "erp/pgdq/version"

Gem::Specification.new do |s|
  s.name        = "erp_pgdq"
  s.version     = Erp::Pgdq::VERSION
  s.authors     = ["Nguyễn Ngọc Sơn"]
  s.email       = ["phatgiaodinhquan.org@gmail.com"]
  s.homepage    = "https://phatgiaodinhquan.org/"
  s.summary     = "Phật Giáo Định Quán"
  s.description = "Ban thông tin Truyền thông Ban Trị Sự Phật Giáo Việt Nam Huyện Định Quán"
  s.license     = "MIT"
  
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  
  s.add_dependency "rails", "~> 5.1.7"
  s.add_dependency "erp_core"
  s.add_dependency "deface"
end