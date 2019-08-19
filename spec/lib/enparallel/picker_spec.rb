describe Picker do
    it 'produces items sequentially' do
        picker = Picker.new([1, 2, 3], :sequential)
        expect(picker.next).to eq(1)
        expect(picker.next).to eq(2)
        expect(picker.next).to eq(3)
        expect(picker.next).to be_nil
    end

    it 'produces items randomly' do
        srand 1337
        picker = Picker.new([1, 2, 3], :random)
        expect(picker.next).to eq(3)
        expect(picker.next).to eq(1)
        expect(picker.next).to eq(2)
        expect(picker.next).to be_nil
    end
end
