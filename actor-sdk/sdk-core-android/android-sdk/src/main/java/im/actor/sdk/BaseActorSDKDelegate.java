package im.actor.sdk;

import android.content.Context;
import android.view.View;

import im.actor.core.AuthState;
import im.actor.sdk.controllers.fragment.auth.BaseAuthFragment;
import im.actor.sdk.controllers.fragment.auth.SignPhoneFragment;
import im.actor.sdk.controllers.fragment.settings.ActorSettingsCategory;
import im.actor.sdk.intents.ActorIntent;

/**
 * Base Implementation of Actor SDK Delegate. This class is recommended to subclass instead
 * of implementing ActorSDKDelegate
 */
public class BaseActorSDKDelegate implements ActorSDKDelegate {

    //
    // Authentication Activity
    //

    @Deprecated
    @Override
    public AuthState getAuthStartState() {
        return AuthState.AUTH_START;
    }

    @Override
    public BaseAuthFragment getSignFragment() {
        return new SignPhoneFragment();
    }

    @Override
    public ActorIntent getAuthStartIntent() {
        return null;
    }

    //
    // Starting Activity
    //

    /**
     * Return non-null to open specific Activity after user's successful log in.
     * If null is specified, result of getStartIntent is used.
     *
     * @return ActorIntent for activity after login
     */
    @Override
    public ActorIntent getStartAfterLoginIntent() {
        return null;
    }

    /**
     * Return non-null to open specific Activity when user is logged in. If null, SDK will launch
     * standard Messaging activity with contacts and recent list
     *
     * @return ActorIntent for start activity
     */
    @Override
    public ActorIntent getStartIntent() {
        return null;
    }

    @Override
    public ActorIntent getSettingsIntent() {
        return null;
    }

    //
    // Hacking settings activity
    //

    @Override
    public View getBeforeNickSettingsView(Context context) {
        return null;
    }

    @Override
    public View getAfterPhoneSettingsView(Context context) {
        return null;
    }

    @Override
    public View getSettingsTopView(Context context) {
        return null;
    }

    @Override
    public View getSettingsBottomView(Context context) {
        return null;
    }

    @Override
    public ActorSettingsCategory[] getBeforeSettingsCategories() {
        return null;
    }

    @Override
    public ActorSettingsCategory[] getAfterSettingsCategories() {
        return null;
    }


}
