# This file is a part of BitArraynge.jl, licensed under the MIT License (MIT).
baremodule BitArraynge
	
	# stuff that is given more methods
	import Base: push!, append!, BitMatrix, BitVector
	# stuff needed to do so
	import Base: @inline, StepRange, Vector, |>, -, range, hcat, vcat
	using BitOperations

	# _cvt_int(x) = (bv = BitVector((false,)) ; bv.chunks[1] = UInt64(x) ; bv.len = 64 ; bv)

	
	_bitindices(I) = range(bsizeof(I)-1, step=(-1), stop=0)

	export bitsof
	@inline bitsof(n::I, b_inds::StepRange) where {I <: Integer} = bget.(n, b_inds)

	@inline bitsof(n::I) where {I <: Integer} = bget.(n, _bitindices(I))
	
	
	export push!
	function push!(V::BitVector, n::I, b_inds::StepRange=0:1:0) where I <: Integer
		append!(V, bitsof(n))
	end
	
	
	export append!
	function append!(V::BitVector, Ns::Vector{I}) where I <: Integer
		b_inds = _bitindices(I)
		for n in Ns
			push!(V, n, b_inds)
		end
	end
	
	
	export BitMatrix
	function BitMatrix(V::Vector{I}) where {I <: Integer}
		hcat((V .|> bitsof)...)
	end
	
	
	export BitVector
	function BitVector(V::Vector{I}) where {I <: Integer}
		vcat((v .|> bitsof)...)
	end

	@inline BitVector(n::I) where {I <: Integer} = bitsof.(n)
	
end # module
