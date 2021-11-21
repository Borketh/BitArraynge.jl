# This file is a part of BitArraynge.jl, licensed under the MIT License (MIT).
baremodule BitArraynge
	
	using Base
	using BitOperations

	#= Credit to Gandalf#4004 in the Humans of Julia discord
	   I might use this at some point =#
	# _cvt_int(x) = (bv = BitVector((false,)) ; bv.chunks[1] = UInt64(x) ; bv.len = 64 ; bv)

	_bitindices(I) = range(bsizeof(I)-1, step=(-1), stop=0)

	export bitsof
	@inline bitsof(n::I, b_inds::StepRange) where {I <: Integer} = bget.(n, b_inds)

	@inline bitsof(n::I) where {I <: Integer} = bget.(n, _bitindices(I))
	
	
	export appendbitsof!
	appendbitsof!(V::BitVector, n::I) where I <: Integer = append!(V, bitsof(n, _bitindices(I)))

	appendbitsof!(V::BitVector, n::I, bitindices::StepRange) where I <: Integer = append!(V, bitsof(n, bitindices))
	
	function appendbitsof!(V::BitVector, N::Vector{I}) where I <: Integer
		bitindices = _bitindices(I)
		for n in N
			appendbitsof!(V, n, bitindices)
		end
	end
	
	
	export bmat_from_ints
	function bmat_from_ints(V::Vector{I}) where {I <: Integer}
		hcat((V .|> bitsof)...)
	end
	
	
	export bvec_from_ints
	function bvec_from_ints(V::Vector{I}) where {I <: Integer}
		vcat((v .|> bitsof)...)
	end

	export bvec_from_int
	@inline bvec_from_int(n::I) where {I <: Integer} = bitsof.(n)
	
end # module
