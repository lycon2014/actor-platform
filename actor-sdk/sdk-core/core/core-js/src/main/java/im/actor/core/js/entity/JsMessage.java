/*
 * Copyright (C) 2015 Actor LLC. <https://actor.im>
 */

package im.actor.core.js.entity;

import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.core.client.JsArray;
import com.google.gwt.core.client.JsArrayInteger;
import com.google.gwt.core.client.JsArrayString;
import com.google.gwt.core.client.JsDate;

import im.actor.core.api.ApiTextExMarkdown;
import im.actor.core.entity.Message;
import im.actor.core.entity.Peer;
import im.actor.core.entity.Reaction;
import im.actor.core.entity.content.ContactContent;
import im.actor.core.entity.content.DocumentContent;
import im.actor.core.entity.content.FileLocalSource;
import im.actor.core.entity.content.FileRemoteSource;
import im.actor.core.entity.content.LocationContent;
import im.actor.core.entity.content.PhotoContent;
import im.actor.core.entity.content.ServiceContent;
import im.actor.core.entity.content.TextContent;
import im.actor.core.entity.content.VoiceContent;
import im.actor.core.js.JsMessenger;
import im.actor.runtime.crypto.Base64Utils;
import im.actor.runtime.js.mvvm.JsEntityConverter;

public class JsMessage extends JavaScriptObject {

    public static final JsEntityConverter<Message, JsMessage> CONVERTER = new JsEntityConverter<Message, JsMessage>() {
        @Override
        public JsMessage convert(Message value) {
            JsMessenger messenger = JsMessenger.getInstance();

            String rid = value.getRid() + "";
            String sortKey = value.getSortDate() + "";

            JsPeerInfo sender = messenger.buildPeerInfo(Peer.user(value.getSenderId()));
            boolean isOut = value.getSenderId() == messenger.myUid();
            boolean isOnServer = value.isOnServer();
            String date = messenger.getFormatter().formatTime(value.getDate());
            JsDate fullDate = JsDate.create(value.getDate());

            JsContent content = JsContent.createContent(value.getContent(),
                    value.getSenderId());

            JsArray<JsReaction> reactions = JsArray.createArray().cast();

            for (Reaction r : value.getReactions()) {
                JsArrayInteger uids = (JsArrayInteger) JsArrayInteger.createArray();
                boolean isOwnSet = false;
                for (Integer i : r.getUids()) {
                    uids.push(i);
                    if (i == messenger.myUid()) {
                        isOwnSet = true;
                    }
                }
                reactions.push(JsReaction.create(r.getCode(), uids, isOwnSet));
            }

            return create(rid, sortKey, sender, isOut, date, fullDate, Enums.convert(value.getMessageState()), isOnServer, content,
                    reactions);
        }
    };

    public native static JsMessage create(String rid, String sortKey, JsPeerInfo sender, boolean isOut, String date, JsDate fullDate, String state, boolean isOnServer, JsContent content,
                                          JsArray<JsReaction> reactions)/*-{
        return {
            rid: rid,
            sortKey: sortKey,
            sender: sender,
            isOut: isOut,
            date: date,
            fullDate: fullDate,
            state: state,
            isOnServer: isOnServer,
            content: content,
            reactions: reactions
        };
    }-*/;

    protected JsMessage() {

    }

    public native final String getSortKey()/*-{
        return this.sortKey;
    }-*/;

    public native final boolean isOnServer()/*-{
        return this.isOnServer;
    }-*/;

}