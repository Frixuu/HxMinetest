package minetest;

interface ScheduledJobHandle {

    /**
        Attempts to cancel a scheduled job.
    **/
    @:native("cancel")
    @:luaDotMethod
    public function cancel(): Void;
}
