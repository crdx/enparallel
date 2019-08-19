describe Logger do
    def get_logger(type)
        pool = get_pool_of(5, type)
        pool.drain_wait
        pool.logger
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
end
