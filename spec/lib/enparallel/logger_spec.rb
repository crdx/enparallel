describe Logger do
    def get_log_groups(type)
        pool = get_pool_of(5, type)
        pool.drain_wait
        pool.get_log_groups
    end

    it 'logs succeeded tasks' do
        log_groups = get_log_groups(:good_command)

        expect(log_groups.length).to eq(1)
        expect(log_groups.first.type).to eq(:success)
        expect(log_groups.first.content).to include('echo cheese')
    end

    it 'logs failed tasks' do
        log_groups = get_log_groups(:bad_command)

        expect(log_groups.length).to eq(1)
        expect(log_groups.first.type).to eq(:failure)
        expect(log_groups.first.content).to include('ekko cheese')
    end
end
