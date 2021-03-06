class Hooks::GithubController < Hooks::BaseController
  # POST /hooks/github
  def create
    event = request.headers['X-Github-Event']
    payload = request.request_parameters
    message = {
        name: event_name(event||'empty'),
        payload: payload
    }
    publish('events', message)
    head :ok
  end

  private

  def event_table
    # https://developer.github.com/webhooks/
    # https://developer.github.com/v3/activity/events/types/
    @table ||= {
        commit_comment: 'github.commit.comment',
        create: 'github.branch.create', # branch or tag
        delete: 'github.branch.delete', # branch or tag
        deployment: 'github.deploy.create',
        deployment_status: 'github.deploy.status',
        fork: 'github.repo.fork',
        gollum: 'github.wiki.update',
        issue_comment: 'github.issue.comment',
        issues: 'github.issue.update',
        member: 'github.member.added',
        membership: 'github.member.team', # organization hooks only
        page_build: 'github.page.build',
        public: 'github.repo.public',
        pull_request_review_comment: 'github.pr.comment',
        pull_request: 'github.pr.update',
        push: 'github.repo.push', # default event
        repository: 'github.repo.create', # organization hooks only
        release: 'github.release.create',
        status: 'github.repo.status',
        team_add: 'github.team.update',
        watch: 'github.repo.watch'
    }
  end

  def event_name(event)
    event_table[event.to_sym] || "github.unknown.#{event}"
  end
end

## example payload
## data is accessible as params[:zen], params[:hook_id], etc
# {
#     "zen": "Speak like a human.",
#     "hook_id": 5129642,
#     "hook": {
#         "url": "https://api.github.com/repos/shawncatz/teejay/hooks/5129642",
#         "test_url": "https://api.github.com/repos/shawncatz/teejay/hooks/5129642/test",
#         "ping_url": "https://api.github.com/repos/shawncatz/teejay/hooks/5129642/pings",
#         "id": 5129642,
#         "name": "web",
#         "active": true,
#         "events": [
#             "*"
#         ],
#         "config": {
#             "url": "http://tools.ulive.sh/hooks/github",
#             "content_type": "json",
#             "insecure_ssl": "0",
#             "secret": ""
#         },
#         "last_response": {
#             "code": null,
#             "status": "unused",
#             "message": null
#         },
#         "updated_at": "2015-06-22T23:15:02Z",
#         "created_at": "2015-06-22T23:15:02Z"
#     },
#     "repository": {
#         "id": 37885391,
#         "name": "teejay",
#         "full_name": "shawncatz/teejay",
#         "owner": {
#             "login": "shawncatz",
#             "id": 1661830,
#             "avatar_url": "https://avatars.githubusercontent.com/u/1661830?v=3",
#             "gravatar_id": "",
#             "url": "https://api.github.com/users/shawncatz",
#             "html_url": "https://github.com/shawncatz",
#             "followers_url": "https://api.github.com/users/shawncatz/followers",
#             "following_url": "https://api.github.com/users/shawncatz/following{/other_user}",
#             "gists_url": "https://api.github.com/users/shawncatz/gists{/gist_id}",
#             "starred_url": "https://api.github.com/users/shawncatz/starred{/owner}{/repo}",
#             "subscriptions_url": "https://api.github.com/users/shawncatz/subscriptions",
#             "organizations_url": "https://api.github.com/users/shawncatz/orgs",
#             "repos_url": "https://api.github.com/users/shawncatz/repos",
#             "events_url": "https://api.github.com/users/shawncatz/events{/privacy}",
#             "received_events_url": "https://api.github.com/users/shawncatz/received_events",
#             "type": "User",
#             "site_admin": false
#         },
#         "private": false,
#         "html_url": "https://github.com/shawncatz/teejay",
#         "description": null,
#         "fork": false,
#         "url": "https://api.github.com/repos/shawncatz/teejay",
#         "forks_url": "https://api.github.com/repos/shawncatz/teejay/forks",
#         "keys_url": "https://api.github.com/repos/shawncatz/teejay/keys{/key_id}",
#         "collaborators_url": "https://api.github.com/repos/shawncatz/teejay/collaborators{/collaborator}",
#         "teams_url": "https://api.github.com/repos/shawncatz/teejay/teams",
#         "hooks_url": "https://api.github.com/repos/shawncatz/teejay/hooks",
#         "issue_events_url": "https://api.github.com/repos/shawncatz/teejay/issues/events{/number}",
#         "events_url": "https://api.github.com/repos/shawncatz/teejay/events",
#         "assignees_url": "https://api.github.com/repos/shawncatz/teejay/assignees{/user}",
#         "branches_url": "https://api.github.com/repos/shawncatz/teejay/branches{/branch}",
#         "tags_url": "https://api.github.com/repos/shawncatz/teejay/tags",
#         "blobs_url": "https://api.github.com/repos/shawncatz/teejay/git/blobs{/sha}",
#         "git_tags_url": "https://api.github.com/repos/shawncatz/teejay/git/tags{/sha}",
#         "git_refs_url": "https://api.github.com/repos/shawncatz/teejay/git/refs{/sha}",
#         "trees_url": "https://api.github.com/repos/shawncatz/teejay/git/trees{/sha}",
#         "statuses_url": "https://api.github.com/repos/shawncatz/teejay/statuses/{sha}",
#         "languages_url": "https://api.github.com/repos/shawncatz/teejay/languages",
#         "stargazers_url": "https://api.github.com/repos/shawncatz/teejay/stargazers",
#         "contributors_url": "https://api.github.com/repos/shawncatz/teejay/contributors",
#         "subscribers_url": "https://api.github.com/repos/shawncatz/teejay/subscribers",
#         "subscription_url": "https://api.github.com/repos/shawncatz/teejay/subscription",
#         "commits_url": "https://api.github.com/repos/shawncatz/teejay/commits{/sha}",
#         "git_commits_url": "https://api.github.com/repos/shawncatz/teejay/git/commits{/sha}",
#         "comments_url": "https://api.github.com/repos/shawncatz/teejay/comments{/number}",
#         "issue_comment_url": "https://api.github.com/repos/shawncatz/teejay/issues/comments{/number}",
#         "contents_url": "https://api.github.com/repos/shawncatz/teejay/contents/{+path}",
#         "compare_url": "https://api.github.com/repos/shawncatz/teejay/compare/{base}...{head}",
#         "merges_url": "https://api.github.com/repos/shawncatz/teejay/merges",
#         "archive_url": "https://api.github.com/repos/shawncatz/teejay/{archive_format}{/ref}",
#         "downloads_url": "https://api.github.com/repos/shawncatz/teejay/downloads",
#         "issues_url": "https://api.github.com/repos/shawncatz/teejay/issues{/number}",
#         "pulls_url": "https://api.github.com/repos/shawncatz/teejay/pulls{/number}",
#         "milestones_url": "https://api.github.com/repos/shawncatz/teejay/milestones{/number}",
#         "notifications_url": "https://api.github.com/repos/shawncatz/teejay/notifications{?since,all,participating}",
#         "labels_url": "https://api.github.com/repos/shawncatz/teejay/labels{/name}",
#         "releases_url": "https://api.github.com/repos/shawncatz/teejay/releases{/id}",
#         "created_at": "2015-06-22T23:11:40Z",
#         "updated_at": "2015-06-22T23:13:05Z",
#         "pushed_at": "2015-06-22T23:13:05Z",
#         "git_url": "git://github.com/shawncatz/teejay.git",
#         "ssh_url": "git@github.com:shawncatz/teejay.git",
#         "clone_url": "https://github.com/shawncatz/teejay.git",
#         "svn_url": "https://github.com/shawncatz/teejay",
#         "homepage": null,
#         "size": 0,
#         "stargazers_count": 0,
#         "watchers_count": 0,
#         "language": "Ruby",
#         "has_issues": true,
#         "has_downloads": true,
#         "has_wiki": true,
#         "has_pages": false,
#         "forks_count": 0,
#         "mirror_url": null,
#         "open_issues_count": 0,
#         "forks": 0,
#         "open_issues": 0,
#         "watchers": 0,
#         "default_branch": "master"
#     },
#     "sender": {
#         "login": "shawncatz",
#         "id": 1661830,
#         "avatar_url": "https://avatars.githubusercontent.com/u/1661830?v=3",
#         "gravatar_id": "",
#         "url": "https://api.github.com/users/shawncatz",
#         "html_url": "https://github.com/shawncatz",
#         "followers_url": "https://api.github.com/users/shawncatz/followers",
#         "following_url": "https://api.github.com/users/shawncatz/following{/other_user}",
#         "gists_url": "https://api.github.com/users/shawncatz/gists{/gist_id}",
#         "starred_url": "https://api.github.com/users/shawncatz/starred{/owner}{/repo}",
#         "subscriptions_url": "https://api.github.com/users/shawncatz/subscriptions",
#         "organizations_url": "https://api.github.com/users/shawncatz/orgs",
#         "repos_url": "https://api.github.com/users/shawncatz/repos",
#         "events_url": "https://api.github.com/users/shawncatz/events{/privacy}",
#         "received_events_url": "https://api.github.com/users/shawncatz/received_events",
#         "type": "User",
#         "site_admin": false
#     }
# }
