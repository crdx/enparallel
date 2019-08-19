describe Command do
    it 'replaces arguments correctly' do
        command = Command.from_a(['ls', '{}'])
        expect(command.interpolate('cheese')).to eq('ls cheese')
    end
end
