package beluga.module.forum;

import beluga.core.module.Moduler;
import beluga.module.forum.model;

interface Forum extends Module
{

  /**
  * CHANNEL
  */

  public function addChannel(args : {
    label : String,
    parent_key : String 
  }) : Void;

  public function modifyChannel(args : {
    label : String,
    channel_key : String,
    parent_key : String 
  }) : Void;

  public function deleteChannel(args : {
    channel_key : String
  }) : Void;

  /**
  * MESSAGE
  */

  public function addMessage(args : {
    title : String,
    content : String,
    channel_key : String
  }) : Void;

  public function modifyMessage(args : {
    title : String,
    content : String,
    message_key : String,
  }) : Void;

  public function deleteMessage(args : {
    message_key : String
  }) : Void;

  public function moveMessage(args : {
    message_key : String,
    channel_key : String,
  }) : Void;

  /**
  * PERMISSION
  */

  public function addUserToGroup(args : {
    login : String,
    group_key : String,
  }) : Void;

  public function removeUserFromGroup(args : {
    login : String,
    group_key : String,
  }) : Void;

  public function addGroupToChannel(args : {
    group_key : String,
    channel_key : String,
  }) : Void;

  public function removeGroupFromChannel(args : {
    group_key : String,
    channel_key: String,
  }) : Void;
}