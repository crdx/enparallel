describe ThreadPool do
    it 'is the right size' do
        expect(get_pool_of(8).size).to eq(8)
    end

    [0, 1, 2, 3, 5, 8].each do |n|
        it 'renders complete tasks with a D' do
            pool = get_pool_of(n, :good_command)
            pool.drain_wait

            expect(pool.render.uncolorize).to eq('D' * n)
            expect(pool.successful_tasks.length).to eq(n)
            expect(pool.failed_tasks.length).to eq(0)
        end

        it 'renders failed tasks with an F' do
            pool = get_pool_of(n, :bad_command)
            pool.drain_wait

            expect(pool.render.uncolorize).to eq('F' * n)
            expect(pool.failed_tasks.length).to eq(n)
            expect(pool.successful_tasks.length).to eq(0)
        end

        it 'renders unstarted tasks with an S' do
            pool = get_pool_of(n, :good_command)
            expect(pool.render.uncolorize).to eq('S' * n)
        end
    end

    it 'renders running tasks with an R' do
        sleep_time = 0.1
        pool = get_pool_of(2, :sleep_command, sleep_time)
        pool.drain

        sleep sleep_time / 2
        expect(pool.render.uncolorize).to eq('R' * 2)
    end

    # it 'saves the logfiles with output to disk' do
    #     pool = get_pool_of(2, :good_command)
    #     pool.drain_wait

    #     success, failure = StringIO.new, StringIO.new

    #     allow(success).to receive(:path) {/
    #     allow(failure).to receive(:path)

    #     expect(pool).to receive(:get_log_files) { [success, failure] }

    #     pp pool.save_output
    # end
end
