gen_server_timer_issue
======================

Be aware to gen_server timeout use
----------------------------------

This test shows a way when no gen_server timeout will be received.
We will handle timeout when our mailbox is empty for a Timeout. 
If we set Time to 0 it call timeout handler when our mailbox will be empty.
