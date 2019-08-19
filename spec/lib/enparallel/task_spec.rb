describe Task do
    it 'successfully runs a command' do
        task = get_task(:good_command)

        task.run

        expect(task).to have_succeeded

        expect(task.stdout).to eq('cheese')
        expect(task.stderr).to be_empty
        expect(task.char).to eq('D'.green)
    end

    it 'fails to runs a command' do
        task = get_task(:bad_command)

        task.run

        expect(task).not_to have_succeeded

        expect(task.stdout).to be_empty
        expect(task.stderr).to eq('No such file or directory - ekko')
        expect(task.char).to eq('F'.red)
    end
end
