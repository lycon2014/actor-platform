package im.actor.model.api;
/*
 *  Generated by the Actor API Scheme generator.  DO NOT EDIT!
 */

import im.actor.model.droidkit.bser.Bser;
import im.actor.model.droidkit.bser.BserParser;
import im.actor.model.droidkit.bser.BserObject;
import im.actor.model.droidkit.bser.BserValues;
import im.actor.model.droidkit.bser.BserWriter;
import im.actor.model.droidkit.bser.DataInput;
import im.actor.model.droidkit.bser.DataOutput;
import im.actor.model.droidkit.bser.util.SparseArray;
import org.jetbrains.annotations.Nullable;
import org.jetbrains.annotations.NotNull;
import com.google.j2objc.annotations.ObjectiveCName;
import static im.actor.model.droidkit.bser.Utils.*;
import java.io.IOException;
import im.actor.model.network.parser.*;
import java.util.List;
import java.util.ArrayList;

public class Rule extends BserObject {

    private Action action;
    private List<Long> longValues;
    private List<byte[]> rawValues;

    public Rule(@NotNull Action action, @NotNull List<Long> longValues, @NotNull List<byte[]> rawValues) {
        this.action = action;
        this.longValues = longValues;
        this.rawValues = rawValues;
    }

    public Rule() {

    }

    @NotNull
    public Action getAction() {
        return this.action;
    }

    @NotNull
    public List<Long> getLongValues() {
        return this.longValues;
    }

    @NotNull
    public List<byte[]> getRawValues() {
        return this.rawValues;
    }

    @Override
    public void parse(BserValues values) throws IOException {
        this.action = Action.parse(values.getInt(1));
        this.longValues = values.getRepeatedLong(2);
        this.rawValues = values.getRepeatedBytes(3);
    }

    @Override
    public void serialize(BserWriter writer) throws IOException {
        if (this.action == null) {
            throw new IOException();
        }
        writer.writeInt(1, this.action.getValue());
        writer.writeRepeatedLong(2, this.longValues);
        writer.writeRepeatedBytes(3, this.rawValues);
    }

    @Override
    public String toString() {
        String res = "struct Rule{";
        res += "action=" + this.action;
        res += ", longValues=" + this.longValues.size();
        res += ", rawValues=" + this.rawValues.size();
        res += "}";
        return res;
    }

}