module Convert
	def get_hash(new)
		new_hash=Hash.new
		new.each do |k,v|
			new_hash[k]=v
		end
		new_hash
	end

	def get_hash_all(dataset)
		array=[]
		dataset.each do |n|
			array<<get_hash(n)
		end
		array
	end
end
