describe Command do
    it 'replaces arguments correctly' do
        command = Command.from_a(['ls', '{}'])
        expect(command.interpolate('potato')).to eq('ls potato')
    end
end
