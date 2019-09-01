describe Command do
    it 'replaces arguments correctly (safely)' do
        command = Command.from_a(['ls', '{}'])
        expect(command.interpolate_safe('potato pie')).to eq('ls potato\\ pie')
    end

    it 'replaces arguments correctly (unsafely)' do
        command = Command.from_a(['ls', '{}'])
        expect(command.interpolate_unsafe('potato pie')).to eq('ls potato pie')
    end
end
