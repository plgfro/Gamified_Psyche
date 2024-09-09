local Timer = {}
Timer.alarms = {}

Timer.set_alarm = function(time, alarm_finished_function) -- Alarm is in seconds.
    local due_alarm = true
    local alarm_expired = false
    local alarm = {}
    local time_set = os.clock()
    
    alarm.update = function(delta_time)
        if time < 0 then
            alarm_expired = true
            alarm_finished_function()
        end
        time = time - delta_time
    end
    alarm.expired = function()
        return alarm_expired
    end
    table.insert(Timer.alarms, alarm)
    return alarm
end 

Timer.check_alarms = function(delta_time)
    -- Quick and dirty approach: use a new list. otherwise, we go back to our C++ Trauma.
    local new_alarms_list = {}
    for index, alarm in pairs(Timer.alarms) do
        if not alarm.expired() then
            alarm.update(delta_time)
        else
            Timer.alarms[index] = nil
        end
    end
    for index, alarm in pairs(Timer.alarms) do -- Due to skipping over nil, we do not need to check if alarm exists.
        table.insert(new_alarms_list, alarm)
    end
end

return Timer