describe Logger do
    def get_logger(type)
        pool = get_pool_of(5, type)
        pool.drain_wait
        pool.get_logger
    end

    def get_logs(type)
        get_logger(type).get_logs
    end

    it 'logs successful tasks' do
        logs = get_logs(:good_command)
        log = logs.first

        expect(logs.length).to eq(1)
        expect(log.type).to eq(:success)
        expect(log.content).to include('echo potato')
    end

    it 'logs failed tasks' do
        logs = get_logs(:bad_command)
        log = logs.first

        expect(logs.length).to eq(1)
        expect(log.type).to eq(:failure)
        expect(log.content).to include('ekko potato')
    end

    # it 'works out which path it can use' do
    #     logger = get_logger(:good_command)
    #     expect(logger.get_paths.first).to start_with('/tmp')
    #     # log = logs.first
    # end

    # it 'writes logs to disk' do
    #     pool = get_pool_of(5)
    #     pool.drain_wait
    #     pool.save_logs_to_disk
    # end
end
