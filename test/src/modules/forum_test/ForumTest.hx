// Copyright 2014 The Beluga Project Developers. See the LICENCE.md
// file at the top-level directory of this distribution and at
// http://haxebeluga.github.io/licence.html.
//
// Licensed under the MIT License.
// This file may not be copied, modified, or distributed
// except according to those terms.

package modules.forum_test;

import haxe.web.Dispatch;
import haxe.Resource;
import haxe.CallStack;

import main_view.Renderer;

import beluga.Beluga;
import beluga.module.account.model.User;
import beluga.module.account.Account;
import beluga.module.forum.Forum;
import beluga.module.forum.ForumErrorKind;

#if php
import php.Web;
#end

class ForumTest {
    public var beluga(default, null) : Beluga;
    public var forum(default, null) : Forum;

    public function new(beluga : Beluga) {
        this.beluga = beluga;
        this.forum = beluga.getModuleInstance(Forum);

        this.forum.triggers.defaultForum.add(this.doDefault);
        this.forum.triggers.redirectCreateTopic.add(this.redirectCreateTopic);
        this.forum.triggers.redirectCreateCategory.add(this.redirectCreateCategory);
        this.forum.triggers.createTopicFail.add(this.createTopicFail);
        this.forum.triggers.createTopicSuccess.add(this.doDefault);
        this.forum.triggers.createCategoryFail.add(this.createCategoryFail);
        this.forum.triggers.createCategorySuccess.add(this.doDefault);
        this.forum.triggers.printTopic.add(this.printTopic);
        this.forum.triggers.redirectPostMessage.add(this.printPostMessage);
        this.forum.triggers.postMessageSuccess.add(this.printTopic);
        this.forum.triggers.postMessageFail.add(this.postMessageFail);
        this.forum.triggers.redirectEditMessage.add(this.printEditMessage);
        this.forum.triggers.editMessageSuccess.add(this.printTopic);
        this.forum.triggers.editMessageFail.add(this.editMessageFail);
        this.forum.triggers.redirectEditCategory.add(this.printEditCategory);
        this.forum.triggers.editCategorySuccess.add(this.doDefault);
        this.forum.triggers.editCategoryFail.add(this.editCategoryFail);
        this.forum.triggers.deleteCategorySuccess.add(this.doDefault);
        this.forum.triggers.deleteCategoryFail.add(this.failFunction);
        this.forum.triggers.deleteTopicSuccess.add(this.doDefault);
        this.forum.triggers.deleteTopicFail.add(this.failFunction);
        this.forum.triggers.solveTopicSuccess.add(this.printTopic);
        this.forum.triggers.solveTopicFail.add(this.failFunction);
        this.forum.triggers.unsolveTopicSuccess.add(this.printTopic);
        this.forum.triggers.unsolveTopicFail.add(this.failFunction);
    }

    public function doDefault() {
        var html = Renderer.renderDefault("page_forum", "Forum", {
            forumWidget: forum.widgets.forum.render()
        });
        Sys.print(html);
    }

    public function printTopic() {
        var html = Renderer.renderDefault("page_forum", "Forum", {
            forumWidget: forum.widgets.topic.render()
        });
        Sys.print(html);
    }

    public function redirectCreateCategory() {
        var html = Renderer.renderDefault("page_forum", "Forum", {
            forumWidget: forum.widgets.create_category.render()
        });
        Sys.print(html);
    }

    public function createCategoryFail(args : {error : ForumErrorKind}) {
        return redirectCreateCategory();
    }

    public function redirectCreateTopic() {
        var html = Renderer.renderDefault("page_forum", "Forum", {
            forumWidget: forum.widgets.create_topic.render()
        });
        Sys.print(html);
    }

    public function createTopicFail(args : {error : ForumErrorKind}) {
        return redirectCreateTopic();
    }

    public function printPostMessage() {
        var html = Renderer.renderDefault("page_forum", "Forum", {
            forumWidget: forum.widgets.post_message.render()
        });
        Sys.print(html);
    }

    public function postMessageFail(args : {error : ForumErrorKind}) {
        return doDefault();
    }

    public function printEditMessage() {
        var html = Renderer.renderDefault("page_forum", "Forum", {
            forumWidget: forum.widgets.edit_message.render()
        });
        Sys.print(html);
    }

    public function editMessageFail(args : {error : ForumErrorKind}) {
        return doDefault();
    }

    public function printEditCategory() {
        var html = Renderer.renderDefault("page_forum", "Forum", {
            forumWidget: forum.widgets.edit_category.render()
        });
        Sys.print(html);
    }

    public function editCategoryFail(args : {error : ForumErrorKind}) {
        return printEditCategory();
    }

    public function failFunction(args : {error : ForumErrorKind}) {
        return doDefault();
    }
}