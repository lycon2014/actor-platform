package im.actor.model.api.rpc;
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
import static im.actor.model.droidkit.bser.Utils.*;
import java.io.IOException;
import im.actor.model.network.parser.*;
import java.util.List;
import java.util.ArrayList;
import im.actor.model.api.*;

public class ResponseGetAdBatters extends Response {

    public static final int HEADER = 0xa1;
    public static ResponseGetAdBatters fromBytes(byte[] data) throws IOException {
        return Bser.parse(new ResponseGetAdBatters(), data);
    }

    private List<Banner> banners;

    public ResponseGetAdBatters(List<Banner> banners) {
        this.banners = banners;
    }

    public ResponseGetAdBatters() {

    }

    public List<Banner> getBanners() {
        return this.banners;
    }

    @Override
    public void parse(BserValues values) throws IOException {
        List<Banner> _banners = new ArrayList<Banner>();
        for (int i = 0; i < values.getRepeatedCount(1); i ++) {
            _banners.add(new Banner());
        }
        this.banners = values.getRepeatedObj(1, _banners);
    }

    @Override
    public void serialize(BserWriter writer) throws IOException {
        writer.writeRepeatedObj(1, this.banners);
    }

    @Override
    public String toString() {
        String res = "tuple GetAdBatters{";
        res += "}";
        return res;
    }

    @Override
    public int getHeaderKey() {
        return HEADER;
    }
}
