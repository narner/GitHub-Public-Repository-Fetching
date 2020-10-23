//
//  RepositoryModel.swift
//  GitHub-Repo-Fetch
//
//  Created by Nick Arner on 10/21/20.
//

import Foundation

// MARK: - RepositoryElement
class RepositoryElement: Codable {
    let nodeID, archiveURL: String
    let tagsURL: String
    let blobsURL: String
    let mergesURL: String
    let treesURL, issuesURL: String
    let downloadsURL, contributorsURL, subscribersURL: String
    let labelsURL, milestonesURL, commitsURL, keysURL: String
    let forksURL, url: String
    let assigneesURL: String
    let subscriptionURL: String
    let name, notificationsURL: String
    let languagesURL, teamsURL: String
    let statusesURL: String
    let htmlURL: String
    let owner: Owner
    let issueCommentURL: String
    let eventsURL: String
    let commentsURL: String
    let id: Int
    let releasesURL: String
    let deploymentsURL: String
    let fullName, gitTagsURL, gitCommitsURL: String
    let stargazersURL: String
    let collaboratorsURL, branchesURL: String
    let repositoryPrivate: Bool
    let issueEventsURL, gitRefsURL, compareURL, pullsURL: String
    let repositoryDescription: String?
    let contentsURL: String
    let fork: Bool
    let hooksURL: String

    enum CodingKeys: String, CodingKey {
        case nodeID = "node_id"
        case archiveURL = "archive_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case mergesURL = "merges_url"
        case treesURL = "trees_url"
        case issuesURL = "issues_url"
        case downloadsURL = "downloads_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case labelsURL = "labels_url"
        case milestonesURL = "milestones_url"
        case commitsURL = "commits_url"
        case keysURL = "keys_url"
        case forksURL = "forks_url"
        case url
        case assigneesURL = "assignees_url"
        case subscriptionURL = "subscription_url"
        case name
        case notificationsURL = "notifications_url"
        case languagesURL = "languages_url"
        case teamsURL = "teams_url"
        case statusesURL = "statuses_url"
        case htmlURL = "html_url"
        case owner
        case issueCommentURL = "issue_comment_url"
        case eventsURL = "events_url"
        case commentsURL = "comments_url"
        case id
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
        case fullName = "full_name"
        case gitTagsURL = "git_tags_url"
        case gitCommitsURL = "git_commits_url"
        case stargazersURL = "stargazers_url"
        case collaboratorsURL = "collaborators_url"
        case branchesURL = "branches_url"
        case repositoryPrivate = "private"
        case issueEventsURL = "issue_events_url"
        case gitRefsURL = "git_refs_url"
        case compareURL = "compare_url"
        case pullsURL = "pulls_url"
        case repositoryDescription = "description"
        case contentsURL = "contents_url"
        case fork
        case hooksURL = "hooks_url"
    }

    init(nodeID: String, archiveURL: String, tagsURL: String, blobsURL: String, mergesURL: String, treesURL: String, issuesURL: String, downloadsURL: String, contributorsURL: String, subscribersURL: String, labelsURL: String, milestonesURL: String, commitsURL: String, keysURL: String, forksURL: String, url: String, assigneesURL: String, subscriptionURL: String, name: String, notificationsURL: String, languagesURL: String, teamsURL: String, statusesURL: String, htmlURL: String, owner: Owner, issueCommentURL: String, eventsURL: String, commentsURL: String, id: Int, releasesURL: String, deploymentsURL: String, fullName: String, gitTagsURL: String, gitCommitsURL: String, stargazersURL: String, collaboratorsURL: String, branchesURL: String, repositoryPrivate: Bool, issueEventsURL: String, gitRefsURL: String, compareURL: String, pullsURL: String, repositoryDescription: String?, contentsURL: String, fork: Bool, hooksURL: String) {
        self.nodeID = nodeID
        self.archiveURL = archiveURL
        self.tagsURL = tagsURL
        self.blobsURL = blobsURL
        self.mergesURL = mergesURL
        self.treesURL = treesURL
        self.issuesURL = issuesURL
        self.downloadsURL = downloadsURL
        self.contributorsURL = contributorsURL
        self.subscribersURL = subscribersURL
        self.labelsURL = labelsURL
        self.milestonesURL = milestonesURL
        self.commitsURL = commitsURL
        self.keysURL = keysURL
        self.forksURL = forksURL
        self.url = url
        self.assigneesURL = assigneesURL
        self.subscriptionURL = subscriptionURL
        self.name = name
        self.notificationsURL = notificationsURL
        self.languagesURL = languagesURL
        self.teamsURL = teamsURL
        self.statusesURL = statusesURL
        self.htmlURL = htmlURL
        self.owner = owner
        self.issueCommentURL = issueCommentURL
        self.eventsURL = eventsURL
        self.commentsURL = commentsURL
        self.id = id
        self.releasesURL = releasesURL
        self.deploymentsURL = deploymentsURL
        self.fullName = fullName
        self.gitTagsURL = gitTagsURL
        self.gitCommitsURL = gitCommitsURL
        self.stargazersURL = stargazersURL
        self.collaboratorsURL = collaboratorsURL
        self.branchesURL = branchesURL
        self.repositoryPrivate = repositoryPrivate
        self.issueEventsURL = issueEventsURL
        self.gitRefsURL = gitRefsURL
        self.compareURL = compareURL
        self.pullsURL = pullsURL
        self.repositoryDescription = repositoryDescription
        self.contentsURL = contentsURL
        self.fork = fork
        self.hooksURL = hooksURL
    }
}

// MARK: - Owner
class Owner: Codable {
    let login, gravatarID: String
    let id: Int
    let starredURL: String
    let siteAdmin: Bool
    let nodeID: String
    let receivedEventsURL, htmlURL: String
    let type: TypeEnum
    let followersURL, url, subscriptionsURL: String
    let eventsURL: String
    let reposURL: String
    let gistsURL, followingURL: String
    let organizationsURL, avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case gravatarID = "gravatar_id"
        case id
        case starredURL = "starred_url"
        case siteAdmin = "site_admin"
        case nodeID = "node_id"
        case receivedEventsURL = "received_events_url"
        case htmlURL = "html_url"
        case type
        case followersURL = "followers_url"
        case url
        case subscriptionsURL = "subscriptions_url"
        case eventsURL = "events_url"
        case reposURL = "repos_url"
        case gistsURL = "gists_url"
        case followingURL = "following_url"
        case organizationsURL = "organizations_url"
        case avatarURL = "avatar_url"
    }

    init(login: String, gravatarID: String, id: Int, starredURL: String, siteAdmin: Bool, nodeID: String, receivedEventsURL: String, htmlURL: String, type: TypeEnum, followersURL: String, url: String, subscriptionsURL: String, eventsURL: String, reposURL: String, gistsURL: String, followingURL: String, organizationsURL: String, avatarURL: String) {
        self.login = login
        self.gravatarID = gravatarID
        self.id = id
        self.starredURL = starredURL
        self.siteAdmin = siteAdmin
        self.nodeID = nodeID
        self.receivedEventsURL = receivedEventsURL
        self.htmlURL = htmlURL
        self.type = type
        self.followersURL = followersURL
        self.url = url
        self.subscriptionsURL = subscriptionsURL
        self.eventsURL = eventsURL
        self.reposURL = reposURL
        self.gistsURL = gistsURL
        self.followingURL = followingURL
        self.organizationsURL = organizationsURL
        self.avatarURL = avatarURL
    }
}

enum TypeEnum: String, Codable {
    case organization = "Organization"
    case user = "User"
}

typealias Repository = RepositoryElement
