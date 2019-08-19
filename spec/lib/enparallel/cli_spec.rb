describe CLI do
    it 'parses arguments correctly' do
        stdin = double
        expect(stdin).to receive(:each_line) { ['cheese'] }

        cli = CLI.parse('--workers 13 --pick random ls {}', stdin)

        expect(cli.command).to be_instance_of Command
        expect(cli.workers).to eq(13)
        expect(cli.inputs).to eq(['cheese'])
        expect(cli.pick).to eq('random')
    end
end
