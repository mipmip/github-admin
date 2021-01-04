require "octokit"
require "dotenv"
require "clim"
require "tallboy"

module GithubAdmin
  VERSION = "0.1.1"

  config_file = Path["~/.config/github-admin"].expand(home: true)
  begin
    Dotenv.load config_file
  rescue
    print "Could not load config file: " + config_file.to_s + "\n"
    print "It should have these vars:\n\n"
    print "GH_USER=username\n"
    print "GH_PAT=PERSONAL_ACCESS_TOKEN\n"
    exit 1
  end

  class Cli < Clim

    main do
      desc "help"
      usage "gdadm help"
      run do |opts, args|
        puts opts.help_string
      end

      sub "version" do
        desc "version"
        usage "ghadm version"
        run do |opts, args|
          puts GithubAdmin::VERSION
        end
      end

      sub "repo" do
        desc "repo tasks"
        usage "ghadm repo command arguments"
        run do |opts, args|
          puts opts.help_string
        end

        sub "list" do
          desc "list repositories"
          usage "ghadm repo list"
          run do |opts, args|
            print "My repositories\n"

            github = Octokit.client(ENV["GH_USER"], ENV["GH_PAT"])
            repos = github.repositories(ENV["GH_USER"])
            repos_all = repos.fetch_all

            header_cols = ["name", "stars", "fork"]

            table = Tallboy.table do
              columns do
                header_cols.each do | col |
                  add col
                end
              end
              header
              repos.fetch_all.each do | repo|
                row [repo.name, repo.stargazers_count, (repo.fork ? "true" : "")]
              end
            end
            puts table.render

          end
        end

        sub "web" do
          desc "open repository in web browser"
          usage "ghadm repo web [name]"
          run do |opts, args|
            args.argv.each do | repo |
              Process.run("xdg-open",shell: true, args: {"https://github.com/"+ENV["GH_USER"]+"/"+repo})
            end
          end
        end

        sub "delete" do
          desc "delete repository"
          usage "ghadm repo delete [name]"
          run do |opts, args|
            args.argv.each do | repo |
              github = Octokit.client(ENV["GH_USER"], ENV["GH_PAT"])
              if github.delete_repository(ENV["GH_USER"]+"/"+ repo)
                print "Deleted " + ENV["GH_USER"]+"/"+ repo + "\n"
              end
            end
          end
        end


      end

    end
  end
end
GithubAdmin::Cli.start(ARGV)
