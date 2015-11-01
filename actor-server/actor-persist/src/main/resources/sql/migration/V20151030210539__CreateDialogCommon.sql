CREATE TABLE dialogs_common (
  peer_type INT NOT NULL,
  peer_id INT NOT NULL,
  last_message_date timestamp NOT NULL DEFAULT NOW(),
  last_received_at timestamp NOT NULL DEFAULT NOW(),
  last_read_at timestamp NOT NULL DEFAULT NOW()
);

CREATE INDEX on dialogs_common(peer_type, peer_id, last_read_at);
