package im.actor.sdk.controllers.conversation.messages;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.HashMap;

import im.actor.core.entity.Message;
import im.actor.core.entity.content.AbsContent;
import im.actor.core.entity.content.ContactContent;
import im.actor.core.entity.content.DocumentContent;
import im.actor.core.entity.content.LocationContent;
import im.actor.core.entity.content.PhotoContent;
import im.actor.core.entity.content.ServiceContent;
import im.actor.core.entity.content.TextContent;
import im.actor.core.entity.content.VideoContent;
import im.actor.core.entity.content.VoiceContent;
import im.actor.runtime.generic.mvvm.BindedDisplayList;
import im.actor.sdk.R;
import im.actor.runtime.android.view.BindedListAdapter;
import im.actor.sdk.controllers.fragment.ActorBinder;

public class MessagesAdapter extends BindedListAdapter<Message, MessageHolder> {

    private MessagesFragment messagesFragment;
    private Context context;
    private long firstUnread = -1;
    protected HashMap<Long, Message> selected = new HashMap<Long, Message>();
    private ActorBinder BINDER = new ActorBinder();

    public MessagesAdapter(BindedDisplayList<Message> displayList,
                           MessagesFragment messagesFragment, Context context) {
        super(displayList);

        this.messagesFragment = messagesFragment;
        this.context = context;
    }

    public Message[] getSelected() {
        return selected.values().toArray(new Message[selected.size()]);
    }

    public boolean isSelected(Message msg) {
        return selected.containsKey(msg.getRid());
    }

    public void setSelected(Message msg, boolean isSelected) {
        if (isSelected) {
            selected.put(msg.getRid(), msg);
        } else {
            selected.remove(msg.getRid());
        }
        notifyDataSetChanged();
    }

    public int getSelectedCount() {
        return selected.size();
    }

    public void clearSelection() {
        selected.clear();
        notifyDataSetChanged();
    }

    public MessagesFragment getMessagesFragment() {
        return messagesFragment;
    }

    public long getFirstUnread() {
        return firstUnread;
    }

    public void setFirstUnread(long firstUnread) {
        this.firstUnread = firstUnread;
    }

    @Override
    public int getItemViewType(int position) {
        AbsContent content = getItem(position).getContent();
        if (content instanceof TextContent) {
            return 0;
        } else if (content instanceof ServiceContent) {
            return 1;
        } else if (content instanceof PhotoContent) {
            return 2;
        } else if (content instanceof VideoContent) {
            return 2;
        } else if (content instanceof VoiceContent) {
            return 4;
        } else if (content instanceof DocumentContent) {
            return 3;
        } else if (content instanceof ContactContent) {
            return 5;
        } else if (content instanceof LocationContent) {
            return 6;
        } else {
            return 7;
        }
    }

    protected View inflate(int id, ViewGroup viewGroup) {
        return LayoutInflater
                .from(context)
                .inflate(id, viewGroup, false);
    }

    @Override
    public MessageHolder onCreateViewHolder(ViewGroup viewGroup, int viewType) {
        switch (viewType) {
            case 0:
                return new TextHolder(this, inflate(R.layout.adapter_dialog_text, viewGroup));
            case 1:
                return new ServiceHolder(this, inflate(R.layout.adapter_dialog_service, viewGroup));
            case 2:
                return new PhotoHolder(this, inflate(R.layout.adapter_dialog_photo, viewGroup));
            case 3:
                return new DocHolder(this, inflate(R.layout.adapter_dialog_doc, viewGroup));
            case 4:
                return new AudioHolder(this, inflate(R.layout.adapter_dialog_audio, viewGroup));
            case 5:
                return new ContactHolder(this, inflate(R.layout.adapter_dialog_contact, viewGroup));
            case 6:
                return new LocationHolder(this, inflate(R.layout.adapter_dialog_locaton, viewGroup));
            default:
                return new UnsupportedHolder(this, inflate(R.layout.adapter_dialog_text, viewGroup));
        }
    }

    @Override
    public void onBindViewHolder(MessageHolder dialogHolder, int index, Message item) {
        Message prev = null;
        Message next = null;
        if (index > 1) {
            next = getItem(index - 1);
        }
        if (index < getItemCount() - 1) {
            prev = getItem(index + 1);
        }
        PreprocessedList list = ((PreprocessedList) getPreprocessedList());
        dialogHolder.bindData(item, prev, next, list.getPreprocessedData()[index]);
    }

    @Override
    public void onViewRecycled(MessageHolder holder) {
        holder.unbind();
    }

    public ActorBinder getBinder() {
        return BINDER;
    }
}