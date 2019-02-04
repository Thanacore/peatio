require 'bump'

def bot_username
  ENV.fetch('BOT_USERNAME', 'kite-bot')
end

def repository_slug
  ENV.fetch('REPOSITORY_SLUG', 'rubykube/peatio')
end

namespace 'release' do

  desc 'Bump the version of the application'
  task :travis do
    unless ENV['TRAVIS_BRANCH'] == 'master'
      Kernel.abort 'Bumping version aborted: GitHub pull request detected.'
    end

    if ENV['TRAVIS_PULL_REQUEST'] != 'false'
      Kernel.abort 'Bumping version aborted: GitHub pull request detected.'
    end

    unless ENV['TRAVIS_TAG'].to_s.empty?
      Kernel.abort 'Bumping version aborted: the build has been triggered by Git tag.'
    end

    sh %(git config --global user.name 'OpenWare')
    sh %(git config --global user.email 'support@openware.com')
    sh %(git remote add authenticated-origin https://#{bot_username}:#{ENV.fetch('GITHUB_API_KEY')}@github.com/#{repository_slug})
    next_version = Bump::Bump.send(:next_version, Bump::Bump.current, 'patch')
    sh %(V='#{next_version}' bin/gendocs)
    sh %(git add -A)
    Bump::Bump.run('patch', commit_message: '[skip ci]', tag: false)
    sh %(git tag #{Bump::Bump.current})
    sh %(git push --tags authenticated-origin HEAD:#{ENV.fetch('TRAVIS_BRANCH')})
  end

  task :drone do
    unless ENV['DRONE_BRANCH'] == 'master'
      Kernel.abort 'Bumping version aborted: GitHub pull request detected.'
    end

    if ENV['DRONE_PULL_REQUEST'].to_s.empty?
      Kernel.abort 'Bumping version aborted: GitHub pull request detected.'
    end

    unless ENV['DRONE_TAG'].to_s.empty?
      Kernel.abort 'Bumping version aborted: the build has been triggered by Git tag.'
    end

    sh %(git config --global user.name 'OpenWare')
    sh %(git config --global user.email 'support@openware.com')
    sh %(git remote add authenticated-origin https://#{bot_username}:#{ENV.fetch('GITHUB_API_KEY')}@github.com/#{repository_slug})
    next_version = Bump::Bump.send(:next_version, Bump::Bump.current, 'patch')
    sh %(V='#{next_version}' bin/gendocs)
    sh %(git add -A)
    Bump::Bump.run('patch', commit_message: '[skip ci]', tag: false)
    sh %(git tag #{Bump::Bump.current})
    sh %(git push --tags authenticated-origin HEAD:#{ENV.fetch('TRAVIS_BRANCH')})
  end
end
