package minetest;

extern interface ScheduledJobHandle {

    /**
        Attempts to cancel a scheduled job.
    **/
    @:native("cancel")
    @:luaDotMethod
    function cancel(): Void;
}
