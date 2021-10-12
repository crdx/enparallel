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

        expect(log_groups.first.to_soml).to include('CommandLine echo cheese')
        expect(log_groups.first.to_soml).to include('StandardOutput cheese')
        expect(log_groups.first.to_soml).to include('ExitStatus 0')

        expect(log_groups.first.to_soml).not_to include('StandardError')
    end

    it 'logs failed tasks' do
        log_groups = get_log_groups(:bad_command)

        expect(log_groups.length).to eq(1)
        expect(log_groups.first.type).to eq(:failure)

        expect(log_groups.first.to_soml).to include('CommandLine ekko cheese')
        expect(log_groups.first.to_soml).to include('ExitStatus 1')
        expect(log_groups.first.to_soml).to include('StandardError No such file or directory - ekko')

        expect(log_groups.first.to_soml).not_to include('StandardOutput')
    end

    let (:task) { 'cheese' }
    let (:path) { '/fake/path' }

    it 'writes tasks to disk' do
        expect(File).to receive(:write).with(path, task + "\n").and_return(100)

        log_group = LogGroup.new(:success, [task])
        expect(log_group.write(path)).to eq('100B')
    end
end
