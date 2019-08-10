describe Util do
    describe 'bytes_to_human' do
        it 'converts bytes to human-readable' do
            expect(Util.bytes_to_human(1000)).to eq('1000B')
            expect(Util.bytes_to_human(1024)).to eq('1K')
            expect(Util.bytes_to_human(1050)).to eq('1K')
            expect(Util.bytes_to_human(2050)).to eq('2K')
        end
    end
end
