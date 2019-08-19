describe Logger do
    def get_logs(type)
        pool = get_pool_of(5, type)
        pool.drain_wait
        pool.get_logs
    end

    it 'logs successful tasks' do
        logs = get_logs(:good_command)

        expect(logs.length).to eq(1)
        expect(logs.first.type).to eq(:success)
        expect(logs.first.content).to include('echo potato')
    end

    it 'logs failed tasks' do
        logs = get_logs(:bad_command)

        expect(logs.length).to eq(1)
        expect(logs.first.type).to eq(:failure)
        expect(logs.first.content).to include('ekko potato')
    end
end
